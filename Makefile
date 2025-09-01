.PHONY: help test linting syntax check verify dev-check

.DEFAULT_GOAL := help

help:
	@echo "Available test commands:"
	@echo "  make test      - 全テスト実行（linting + syntax + check）"
	@echo "  make lint	    - YAML・Ansible Lint実行"
	@echo "  make syntax    - Playbook構文チェック"
	@echo "  make check     - Dry run（変更内容の事前確認）"
	@echo "  make verify    - セットアップ結果の確認"
	@echo "  make dev-check - 開発時の簡易チェック"

lint:
	@echo "Running yamllint..."
	@yamllint . || (echo "❌ yamllint failed" && exit 1)
	@echo "Running ansible-lint..."
	@ansible-lint || (echo "❌ ansible-lint failed" && exit 1)
	@echo "✅ All linting passed!"

syntax:
	@echo "Checking Ansible playbook syntax..."
	@ansible-playbook site.yml --syntax-check || (echo "❌ Syntax check failed" && exit 1)
	@echo "✅ Syntax check passed!"

check:
	@echo "Running dry run check..."
	@ansible-playbook site.yml --check || (echo "❌ Dry run failed" && exit 1)
	@echo "✅ Dry run completed!"

test: linting syntax check
	@echo "✅ All tests passed successfully!"

verify:
	@echo "Verifying setup..."
	@bash bin/verify-setup.sh

dev-check:
	@echo "Quick development check..."
	@yamllint . --format=parsable || (echo "❌ yamllint failed" && exit 1)
	@ansible-lint --quiet || (echo "❌ ansible-lint failed" && exit 1)
	@ansible-playbook site.yml --syntax-check || (echo "❌ syntax check failed" && exit 1)
	@echo "✅ Quick check passed!"
