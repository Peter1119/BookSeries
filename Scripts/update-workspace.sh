#!/bin/bash

# Workspace.swift 자동 업데이트 스크립트
# Feature 디렉터리를 스캔해서 자동으로 Workspace.swift 업데이트

echo "🔄 Updating Workspace.swift..."

# Feature 디렉터리에서 모든 하위 디렉터리 찾기
FEATURES=$(find Feature -maxdepth 1 -mindepth 1 -type d | sort)

# Workspace.swift 파일 생성
cat > Workspace.swift << 'EOF'
import ProjectDescription

let workspace = Workspace(
    name: "ModularAppTemplate",
    projects: [
        "{{projectName}}App",
        "Domain",
        "DesignSystem",
        "Data",
        "Network",
EOF

# Feature 프로젝트들 추가
for feature in $FEATURES; do
    echo "        \"$feature\"," >> Workspace.swift
done

# 파일 종료
cat >> Workspace.swift << 'EOF'
    ]
)
EOF

echo "✅ Workspace.swift 업데이트 완료!"
echo ""
echo "포함된 Feature들:"
for feature in $FEATURES; do
    echo "  - $feature"
done