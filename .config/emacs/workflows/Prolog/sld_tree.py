import os

class TreeNode:
    def __init__(self, call):
        # Remove '? creep' and '?' from the call
        self.call = call.replace(' ? creep', '').replace(' ?', '')
        self.children = []

    def add_child(self, child):
        self.children.append(child)

    def to_ascii(self, prefix="", is_last=True):
        result = f"{prefix}{'└── ' if is_last else '├── '}{self.call}\n"
        prefix += "    " if is_last else "│   "
        for i, child in enumerate(self.children):
            result += child.to_ascii(prefix, i == len(self.children) - 1)
        return result


def load_temp_file(file_path):
    """Load the Prolog file path and query from temp.txt."""
    with open(file_path, 'r') as temp_file:
        lines = temp_file.readlines()
    if len(lines) < 2:
        raise ValueError("temp.txt must contain at least two lines: the file path and the query.")
    return [line.strip() for line in lines]  # Strip each line

# Main logic
try:
    # Get the Prolog process output
    temp_file_path = "~/.config/emacs/workflows/Prolog/sld_tree_temp.txt"
    temp_file = os.path.expanduser(temp_file_path)
    lines = load_temp_file(temp_file)  # Load and strip lines
    output = lines[1]  # Assuming query results are on the second line.

    # Build the tree
    root = TreeNode("Prolog Process")
    stack = [root]
    for line in lines:
        if line.startswith("Call:"):
            _, details = line.split(": ", 1)
            new_node = TreeNode(details)
            stack[-1].add_child(new_node)
            stack.append(new_node)
        elif line.startswith("Exit:"):
            stack.pop()

    # Print the tree as ASCII
    print(root.to_ascii())

except Exception as e:
    print(f"Error: {e}")
