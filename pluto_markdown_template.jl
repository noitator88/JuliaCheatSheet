### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ 7503acaa-c2b4-4010-82ee-93e1dfe96807
begin
  using PlutoUI
  TableOfContents()
end

# ╔═╡ 04f817d6-7344-4597-9e41-4293302c8ef1
md"""
# Markdown in Pluto notebook
"""

# ╔═╡ f881a839-4cce-42cd-bc24-933f25d72967
md"""
## 字体

1. **粗体**, __This is bold text__

2. *斜体*, _This is italic text_

"""

# ╔═╡ 4b6640d9-a74a-426a-a69f-6b843cf718a4
md"""
## 排版

1. 分段

第一段

第二段 用空白行分割段落

2. 引用

> This is a blockquote

>  多行引用
>
>         这样
>             就可以
>                   啊~

3. 分割线

---

***

4. 列表
    1. 编号二

        编号符号自动生成
        * 无编号列表
        * 用4个空格生成多层列表
    2. 编号三
"""

# ╔═╡ 5a41af82-3362-49d5-8c9a-e96bcad20332
md"""
## 图片

![](https://www.python.org/static/community_logos/python-logo-master-v3-TM.png)

"""

# ╔═╡ 789b18c3-8ad8-4285-99ce-7ace42220282
md"""
## url 链接

[wikipedia英文版](https://en.wikipedia.org)

"""

# ╔═╡ 0b8d7dd8-48c3-4d34-8c78-17af4ca5b54e
md"""
## 代码

1. **javascript**
```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

2. **python**
```python
s = "Python syntax highlighting"
print s
```

3. **julia**
```julia
for i in 1:3
    print(i)
end
```
"""

# ╔═╡ d527bac5-3893-497e-831e-be497be46f4e
md"""
## 表格

|Header|左对齐|右对齐|中心对齐|
|---|:---|---:|:---:|
|A     |Bbb     |Ccc     | Ddd |
|X     |Yyy     |Zzz     | Uuu |
"""

# ╔═╡ f9e3e6a8-6f11-4463-87bc-c2492a9c92c2
md"""
## math

$\sqrt{k}$

$\begin{eqnarray}
\sum_k \frac{1}{n^2} & = \pi
\end{eqnarray}$


"""

# ╔═╡ 291ebe47-3282-4426-850b-02b9438a7764


# ╔═╡ 134cf3b0-438e-11ec-363b-b7301b045b56
md"""
# Table of Content (TOC)

The following code generate the TOC for the pluto notebook
"""

# ╔═╡ 6145cd1f-1500-4768-a4ae-df9ab68d1b5e
md"CSS for TOC"

# ╔═╡ be8b1611-0474-48b9-83ee-2faf850f02b8
# const toc_css = """
# @media screen and (min-width: 1081px) {
# 	.plutoui-toc.aside {
# 		position:fixed; 
# 		right: 1rem;
# 		top: 5rem; 
# 		width:25%; 
# 		padding: 10px;
# 		border: 3px solid rgba(0, 0, 0, 0.15);
# 		border-radius: 10px;
# 		box-shadow: 0 0 11px 0px #00000010;
# 		/* That is, viewport minus top minus Live Docs */
# 		max-height: calc(100vh - 5rem - 56px);
# 		overflow: auto;
# 		z-index: 50;
# 		background: white;
# 	}
# }

# .plutoui-toc header {
# 	display: block;
# 	font-size: 1.5em;
# 	margin-top: 0.67em;
# 	margin-bottom: 0.67em;
# 	margin-left: 0;
# 	margin-right: 0;
# 	font-weight: bold;
# 	border-bottom: 2px solid rgba(0, 0, 0, 0.15);
# }

# .plutoui-toc section .toc-row {
# 	white-space: nowrap;
# 	overflow: hidden;
# 	text-overflow: ellipsis;
# 	padding-bottom: 2px;
# }

# .highlight-pluto-cell-shoulder {
# 	background: rgba(0, 0, 0, 0.05);
# 	background-clip: padding-box;
# }

# .plutoui-toc section a {
# 	text-decoration: none;
# 	font-weight: normal;
# 	color: gray;
# }
# .plutoui-toc section a:hover {
# 	color: black;
# }

# .plutoui-toc.indent section a.H1 {
# 	font-weight: 700;
# 	line-height: 1em;
# }

# .plutoui-toc.indent section a.H1 {
# 	padding-left: 0px;
# }
# .plutoui-toc.indent section a.H2 {
# 	padding-left: 10px;
# }
# .plutoui-toc.indent section a.H3 {
# 	padding-left: 20px;
# }
# .plutoui-toc.indent section a.H4 {
# 	padding-left: 30px;
# }
# .plutoui-toc.indent section a.H5 {
# 	padding-left: 40px;
# }
# .plutoui-toc.indent section a.H6 {
# 	padding-left: 50px;
# }
# """

# ╔═╡ 3f826109-12a4-4675-ac6d-584614194349
md"Js for TOC"

# ╔═╡ 31fdf653-0772-4e12-90a4-538178aff34e
# const toc_js = toc -> """
# const getParentCell = el => el.closest("pluto-cell")

# const getHeaders = () => {
# 	const depth = Math.max(1, Math.min(6, $(toc.depth))) // should be in range 1:6
# 	const range = Array.from({length: depth}, (x, i) => i+1) // [1, ..., depth]
	
# 	const selector = range.map(i => `pluto-notebook pluto-cell h\${i}`).join(",")
# 	return Array.from(document.querySelectorAll(selector))
# }

# const indent = $(repr(toc.indent))
# const aside = $(repr(toc.aside))

# const render = (el) => html`\${el.map(h => {
# 	const parent_cell = getParentCell(h)

# 	const a = html`<a 
# 		class="\${h.nodeName}" 
# 		href="#\${parent_cell.id}"
# 	>\${h.innerText}</a>`
# 	/* a.onmouseover=()=>{
# 		parent_cell.firstElementChild.classList.add(
# 			'highlight-pluto-cell-shoulder'
# 		)
# 	}
# 	a.onmouseout=() => {
# 		parent_cell.firstElementChild.classList.remove(
# 			'highlight-pluto-cell-shoulder'
# 		)
# 	} */
# 	a.onclick=(e) => {
# 		e.preventDefault();
# 		h.scrollIntoView({
# 			behavior: 'smooth', 
# 			block: 'center'
# 		})
# 	}

# 	return html`<div class="toc-row">\${a}</div>`
# })}`

# const tocNode = html`<nav class="plutoui-toc">
# 	<header>$(toc.title)</header>
# 	<section></section>
# </nav>`
# tocNode.classList.toggle("aside", aside)
# tocNode.classList.toggle("indent", aside)

# const updateCallback = () => {
# 	tocNode.querySelector("section").replaceWith(
# 		html`<section>\${render(getHeaders())}</section>`
# 	)
# }
# updateCallback()


# const notebook = document.querySelector("pluto-notebook")


# // We have a mutationobserver for each cell:
# const observers = {
# 	current: [],
# }

# const createCellObservers = () => {
# 	observers.current.forEach((o) => o.disconnect())
# 	observers.current = Array.from(notebook.querySelectorAll("pluto-cell")).map(el => {
# 		const o = new MutationObserver(updateCallback)
# 		o.observe(el, {attributeFilter: ["class"]})
# 		return o
# 	})
# }
# createCellObservers()

# // And one for the notebook's child list, which updates our cell observers:
# const notebookObserver = new MutationObserver(() => {
# 	updateCallback()
# 	createCellObservers()
# })
# notebookObserver.observe(notebook, {childList: true})

# // And finally, an observer for the document.body classList, to make sure that the toc also works when if is loaded during notebook initialization
# const bodyClassObserver = new MutationObserver(updateCallback)
# bodyClassObserver.observe(document.body, {attributeFilter: ["class"]})

# invalidation.then(() => {
# 	notebookObserver.disconnect()
# 	bodyClassObserver.disconnect()
# 	observers.current.forEach((o) => o.disconnect())
# })

# return tocNode
# """

# ╔═╡ 43e83bac-cac8-41a8-85b2-bb01debca097
# toc() = HTML("""
# 	<script>
# 	$(toc_js((;title="Table of Contents", indent=true, depth=3, aside=true)))
# 	</script>
# 	<style>
# 	$(toc_css)
# 	</style>
# 	""")

# ╔═╡ 8e73cab7-9bc7-4315-8331-f5f8ac97cd53
#toc()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.19"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0bc60e3006ad95b4bb7497698dd7c6d649b9bc06"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "e071adf21e165ea0d904b595544a8e514c8bb42c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.19"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═04f817d6-7344-4597-9e41-4293302c8ef1
# ╠═f881a839-4cce-42cd-bc24-933f25d72967
# ╠═4b6640d9-a74a-426a-a69f-6b843cf718a4
# ╠═5a41af82-3362-49d5-8c9a-e96bcad20332
# ╠═789b18c3-8ad8-4285-99ce-7ace42220282
# ╠═0b8d7dd8-48c3-4d34-8c78-17af4ca5b54e
# ╠═d527bac5-3893-497e-831e-be497be46f4e
# ╠═f9e3e6a8-6f11-4463-87bc-c2492a9c92c2
# ╠═291ebe47-3282-4426-850b-02b9438a7764
# ╠═134cf3b0-438e-11ec-363b-b7301b045b56
# ╟─6145cd1f-1500-4768-a4ae-df9ab68d1b5e
# ╠═be8b1611-0474-48b9-83ee-2faf850f02b8
# ╟─3f826109-12a4-4675-ac6d-584614194349
# ╠═31fdf653-0772-4e12-90a4-538178aff34e
# ╠═43e83bac-cac8-41a8-85b2-bb01debca097
# ╠═8e73cab7-9bc7-4315-8331-f5f8ac97cd53
# ╠═7503acaa-c2b4-4010-82ee-93e1dfe96807
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
