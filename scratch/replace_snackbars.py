import os
import re

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content
    # Find all occurrences of "ScaffoldMessenger.of("
    idx = 0
    while True:
        idx = content.find("ScaffoldMessenger.of(", idx)
        if idx == -1:
            break
            
        # Find the end of the statement by looking for the next semicolon after showSnackBar
        show_idx = content.find("showSnackBar(", idx)
        if show_idx == -1:
            idx += 1
            continue
            
        # Find the end of the statement
        semi_idx = content.find(";", show_idx)
        if semi_idx == -1:
            idx += 1
            continue
            
        full_statement = content[idx:semi_idx+1]
        
        # Now extract the content inside Text(...)
        text_idx = full_statement.find("Text(")
        if text_idx == -1:
            idx = semi_idx + 1
            continue
            
        text_start = text_idx + 5
        # find matching closing parenthesis for Text(
        paren_count = 1
        text_end = -1
        for i in range(text_start, len(full_statement)):
            if full_statement[i] == '(':
                paren_count += 1
            elif full_statement[i] == ')':
                paren_count -= 1
                if paren_count == 0:
                    text_end = i
                    break
                    
        if text_end == -1:
            idx = semi_idx + 1
            continue
            
        text_content = full_statement[text_start:text_end].strip()
        # if text_content has a trailing comma, remove it
        if text_content.endswith(','):
            text_content = text_content[:-1].strip()
            
        replacement = f"Fluttertoast.showToast(msg: {text_content});"
        
        content = content[:idx] + replacement + content[semi_idx+1:]
        # Do not advance idx, because the string length changed, next search from idx
        
    if content != original_content:
        # Check if fluttertoast is imported
        if "import 'package:fluttertoast/fluttertoast.dart';" not in content:
            # Find the last import
            import_pattern = re.compile(r"import\s+['\"].*?['\"];")
            imports = list(import_pattern.finditer(content))
            if imports:
                last_import = imports[-1]
                insert_pos = last_import.end()
                content = content[:insert_pos] + "\nimport 'package:fluttertoast/fluttertoast.dart';" + content[insert_pos:]
            else:
                content = "import 'package:fluttertoast/fluttertoast.dart';\n" + content
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

def main():
    lib_dir = "lib"
    for root, dirs, files in os.walk(lib_dir):
        for file in files:
            if file.endswith('.dart'):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
