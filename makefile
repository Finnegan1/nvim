
setup-molten.nvim:
	brew install imagemagick
	uv venv --clear .venv
	source .venv/bin/activate
	uv pip install pynvim jupyter_client cairosvg plotly kaleido pyperclip nbformat

