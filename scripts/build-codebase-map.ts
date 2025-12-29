#!/usr/bin/env npx ts-node
/**
 * Build a codebase map for the current project
 * Scans the project structure and creates a SKILL.md file
 * that helps Claude understand the codebase layout
 */

import { readdirSync, statSync, writeFileSync, existsSync } from 'fs';
import { join, relative } from 'path';

interface FileInfo {
  path: string;
  type: 'file' | 'directory';
  children?: FileInfo[];
}

const IGNORE_DIRS = [
  'node_modules',
  '.git',
  '.next',
  'dist',
  'build',
  '.turbo',
  'coverage',
  '.claude',
];

const IGNORE_FILES = [
  '.DS_Store',
  'package-lock.json',
  'pnpm-lock.yaml',
  'yarn.lock',
];

function scanDirectory(dir: string, depth: number = 0, maxDepth: number = 4): FileInfo[] {
  if (depth > maxDepth) return [];

  const items: FileInfo[] = [];
  const entries = readdirSync(dir);

  for (const entry of entries) {
    if (IGNORE_DIRS.includes(entry) || IGNORE_FILES.includes(entry)) continue;
    if (entry.startsWith('.') && entry !== '.env.example') continue;

    const fullPath = join(dir, entry);
    const stat = statSync(fullPath);

    if (stat.isDirectory()) {
      items.push({
        path: entry,
        type: 'directory',
        children: scanDirectory(fullPath, depth + 1, maxDepth),
      });
    } else {
      items.push({
        path: entry,
        type: 'file',
      });
    }
  }

  return items.sort((a, b) => {
    if (a.type === b.type) return a.path.localeCompare(b.path);
    return a.type === 'directory' ? -1 : 1;
  });
}

function formatTree(items: FileInfo[], indent: string = ''): string {
  let result = '';

  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const isLast = i === items.length - 1;
    const prefix = isLast ? '└── ' : '├── ';
    const childIndent = indent + (isLast ? '    ' : '│   ');

    result += `${indent}${prefix}${item.path}${item.type === 'directory' ? '/' : ''}\n`;

    if (item.children && item.children.length > 0) {
      result += formatTree(item.children, childIndent);
    }
  }

  return result;
}

function detectPatterns(items: FileInfo[], basePath: string = ''): string[] {
  const patterns: string[] = [];

  for (const item of items) {
    const fullPath = basePath ? `${basePath}/${item.path}` : item.path;

    if (item.type === 'directory') {
      // Detect common patterns
      if (item.path === 'app') patterns.push('Next.js App Router');
      if (item.path === 'pages') patterns.push('Next.js Pages Router');
      if (item.path === 'components') patterns.push('Component directory');
      if (item.path === 'lib') patterns.push('Library/utilities directory');
      if (item.path === 'hooks') patterns.push('Custom React hooks');
      if (item.path === 'actions') patterns.push('Server Actions');
      if (item.path === 'db' || item.path === 'database') patterns.push('Database layer');
      if (item.path === 'api') patterns.push('API routes');

      if (item.children) {
        patterns.push(...detectPatterns(item.children, fullPath));
      }
    }
  }

  return [...new Set(patterns)];
}

function main(): void {
  const projectRoot = process.cwd();
  const outputDir = join(projectRoot, '.claude', 'skills', 'codebase-map');
  const outputFile = join(outputDir, 'SKILL.md');

  console.log('Scanning project structure...');
  const structure = scanDirectory(projectRoot);
  const patterns = detectPatterns(structure);

  const content = `---
name: codebase-map
description: Auto-generated map of this project's structure
generated: ${new Date().toISOString()}
---

# Codebase Map

## Project Structure

\`\`\`
${formatTree(structure)}\`\`\`

## Detected Patterns

${patterns.map(p => `- ${p}`).join('\n') || '- No specific patterns detected'}

## Key Directories

| Directory | Purpose |
|-----------|---------|
| \`app/\` | Next.js App Router pages and layouts |
| \`components/\` | Reusable UI components |
| \`lib/\` | Utility functions and shared code |
| \`db/\` | Database schema and queries |
| \`actions/\` | Server Actions for mutations |
| \`hooks/\` | Custom React hooks |

## Conventions

Based on the project structure, follow these conventions:
- Place new pages in \`app/\`
- Create reusable components in \`components/\`
- Database operations go in \`db/\` or \`lib/db/\`
- Server Actions go in \`actions/\` or colocated with features
`;

  // Ensure directory exists
  if (!existsSync(outputDir)) {
    const { mkdirSync } = require('fs');
    mkdirSync(outputDir, { recursive: true });
  }

  writeFileSync(outputFile, content);
  console.log(`Codebase map written to: ${outputFile}`);
}

main();
