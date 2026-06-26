## Git リポジトリでの作業は必ず worktree を使う

git リポジトリ上でコードを変更する作業は、メインの作業ツリーで直接行なわず、**必ず worktree を作成してその中で行なう**。worktree の作成・操作には k1LoW/git-wt（`git wt` で呼び出せる）を使う。詳細は https://github.com/k1LoW/git-wt を参照。

基本コマンド:
* `git wt` — worktree 一覧を表示（`--json` で JSON 出力）
* `git wt <branch|worktree|path>` — 既存 worktree に切り替え、無ければ新規作成
* `git wt <branch> <start-point>` — 起点を指定して作成（例: `git wt feat origin/main` で最新の `origin/main` 起点に作成）
* `git wt -b <branch> <worktree>` — ブランチ名と worktree 名を分けて新規作成
* `git wt -d <branch|worktree|path>` — worktree を削除。**ブランチはマージ済みのときだけ削除**され、未マージなら残る（消すなら `-D` で強制削除）
* `git wt -m [<old>] <new>` — worktree ディレクトリとブランチをリネーム（`-M` で強制）

注意点:
* **自動実行（非対話シェル）では `git wt <branch>` は cd せずパスを出力するだけ**（cd には `git wt --init <shell>` の shell 統合が必要）。スクリプトでは `--nocd` でパスを取得し、`cd "$(git wt --nocd <branch>)"` のように明示的に移動する
* 新規 worktree には **gitignore 対象・未追跡ファイル（`.env` 等）はコピーされない**。必要なら `wt.copyignored` / `wt.copyuntracked` でコピー、`wt.copy` でパターン指定（例: `.vscode/`）、`wt.symlink` で `node_modules/` 等を symlink 共有
* worktree のベースディレクトリは `wt.basedir`（既定 `.wt`）。現在の設定は `git config wt.basedir` で確認できる
* メインブランチは既定で削除・リネームから保護される（解除は `--allow-delete-default`）

## Git の commit / tag で gpg 署名に失敗したとき

`gpg failed to sign the data` / `secret key not available` のような署名失敗が出たら、まず gpg エージェント系を再起動して、サンドボックス内外の両方で署名できるか確認する。

restart gpg:
* `pkill -9 -f 'gpg-agent|scdaemon|dirmngr|keyboxd' 2>/dev/null`
* `gpgconf --launch all`

check gpg:
* `echo test | gpg --clearsign >/dev/null && echo OK_outside`
* `fence -- bash -c 'echo test | gpg --clearsign >/dev/null && echo OK_inside'`

`OK_outside` のみ成功し `OK_inside` が失敗する場合はサンドボックス内から gpg-agent ソケットに届いていないので、`dangerouslyDisableSandbox: true` で再試行する（`--no-gpg-sign` で署名を回避してはいけない）。
