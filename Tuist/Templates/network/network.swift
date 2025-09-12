import ProjectDescription

fileprivate let template = Template(
    description: "A template for a new Network module.",
    attributes: [],
    items: [
        .file(path: "Network/Project.swift", templatePath: "project.stencil"),
        .file(path: "Network/Sources/Empty.swift", templatePath: "empty.stencil")
    ]
)
