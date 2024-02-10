## Вывести список всех удаленных репозиториев для локального.
---
	vanadiy@vanadiy:~$ git clone git@github.com:tms-dos17-onl/vladimir-bobko.git
	Cloning into 'vladimir-bobko'...
	remote: Enumerating objects: 40, done.
	remote: Counting objects: 100% (40/40), done.
	remote: Compressing objects: 100% (37/37), done.
	remote: Total 40 (delta 12), reused 0 (delta 0), pack-reused 0
	Receiving objects: 100% (40/40), 26.52 KiB | 348.00 KiB/s, done.
	Resolving deltas: 100% (12/12), done.
	vanadiy@vanadiy:~/vladimir-bobko$ git config -l
	user.name=Vladimir Bobko
	user.email=babaika.ko@gmail.com
	core.repositoryformatversion=0
	core.filemode=true
	core.bare=false
	core.logallrefupdates=true
	remote.origin.url=git@github.com:tms-dos17-onl/vladimir-bobko.git
	remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
	branch.main.remote=origin
	branch.main.merge=refs/heads/main
	vanadiy@vanadiy:~/vladimir-bobko$ git remote -v
	origin	git@github.com:tms-dos17-onl/vladimir-bobko.git (fetch)
	origin	git@github.com:tms-dos17-onl/vladimir-bobko.git (push)
---
## Вывести список всех веток.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git branch -a
	* main
	  remotes/origin/HEAD -> origin/main
	  remotes/origin/main
---
## Вывести последниe 3 коммитa с помощью git log.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git log -3
	commit b09f34e71b69312822d12ddfbdffbd938e3ffb41 (HEAD -> main, origin/main, origin/HEAD)
	Author: vanadiy7 <babaika.ko@gmail.com>
	Date:   Wed Jul 26 16:53:16 2023 +0300
	
	    Add files via upload
	
	commit 3cc8084d627533d451cfd11c9baaea3dea595ae6
	Author: vanadiy7 <babaika.ko@gmail.com>
	Date:   Wed Jul 26 16:51:04 2023 +0300
	
	    Create readme
	
	commit 4977bf6418b8ef741da913c96594ab53d9a01385
	Author: vanadiy7 <babaika.ko@gmail.com>
	Date:   Tue Jul 25 17:32:44 2023 +0300
	
	    Add files via upload
---
## Создать пустой файл README.md и сделать коммит.
---
	vanadiy@vanadiy:~/vladimir-bobko$ touch README.md
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is up to date with 'origin/main'.
	
	Untracked files:
	  (use "git add <file>..." to include in what will be committed)
		README.md
	vanadiy@vanadiy:~/vladimir-bobko$ git add README.md
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is up to date with 'origin/main'.
	
	Changes to be committed:
	  (use "git restore --staged <file>..." to unstage)
		new file:   README.md
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -m "Add file readme"
	[main 9bdf2c2] Add file readme
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 README.md
---
## Добавить фразу "Hello, DevOps" в README.md файл и сделать коммит. 
---
	vanadiy@vanadiy:~/vladimir-bobko$ cat README.md 
	"Hello, DevOps"
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is ahead of 'origin/main' by 1 commit.
	  (use "git push" to publish your local commits)
	
	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git restore <file>..." to discard changes in working directory)
		modified:   README.md
	
	no changes added to commit (use "git add" and/or "git commit -a")
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -am "Modify file readme"
	[main 5f8adbb] Modify file readme
	 1 file changed, 1 insertion(+)
---
## Сделать реверт последнего коммита. Вывести последниe 3 коммитa с помощью git log. 
---
	vanadiy@vanadiy:~/vladimir-bobko$ git revert 5f8adbb9a922cc41d2641f158d243a324c880731
	[main 48a619c] Revert "Modify file readme" Sorry!!!
	 1 file changed, 1 deletion(-)
	vanadiy@vanadiy:~/vladimir-bobko$ git log -3
	commit 48a619cb642d25a1d3eb39d13dc33ecdca8e68dd (HEAD -> main)
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 13:22:52 2023 +0300
	
	    Revert "Modify file readme" Sorry!!!
	    
	    This reverts commit 5f8adbb9a922cc41d2641f158d243a324c880731.
	
	commit 5f8adbb9a922cc41d2641f158d243a324c880731
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 13:04:31 2023 +0300
	
	    Modify file readme
	
	commit 9bdf2c29dea8498da3e46c73569d007815e30ecb
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 13:01:04 2023 +0300
	
	    Add file readme
---
## Удалить последние 3 коммита с помощью git reset.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git reset --hard  HEAD~3
	HEAD is now at b09f34e Add files via upload
---
## Вернуть коммит, где добавляется пустой файл README.md. Для этого найти ID коммита в git reflog, а затем сделать cherry-pick.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git reflog
	b09f34e (HEAD -> main, origin/main, origin/HEAD) HEAD@{0}: reset: moving to HEAD~3
	48a619c HEAD@{1}: revert: Revert "Modify file readme" Sorry!!!
	5f8adbb HEAD@{2}: commit: Modify file readme
	9bdf2c2 HEAD@{3}: commit: Add file readme
	b09f34e (HEAD -> main, origin/main, origin/HEAD) HEAD@{4}: clone: from github.com:tms-dos17-onl/vladimir-bobko.git
	vanadiy@vanadiy:~/vladimir-bobko$ git cherry-pick 9bdf2c2
	[main be61923] Add file readme
	 Date: Thu Jul 27 13:01:04 2023 +0300
	 1 file changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 README.md
---
## Удалить последний коммит с помощью git reset.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git reset --hard  HEAD~
	HEAD is now at b09f34e Add files via upload
---
## Переключиться на ветку main или master. Если ветка называется master, то переименовать её в main.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git branch -a
	* main
	  remotes/origin/HEAD -> origin/main
	  remotes/origin/main
		**Ветка называется main**
---
## Скопировать файл <https://github.com/tms-dos17-onl/_sandbox/blob/main/.github/workflows/validate-shell.yaml>, положить его по такому же относительному пути в репозиторий. Создать коммит и запушить его в удаленный репозиторий.
---
	vanadiy@vanadiy:~/vladimir-bobko$ mkdir .github
	vanadiy@vanadiy:~/vladimir-bobko$ cd .github
	vanadiy@vanadiy:~/vladimir-bobko/.github$ mkdir worklows
	vanadiy@vanadiy:~/vladimir-bobko$ mv validate-shell.yaml ./.github/workflows/
	vanadiy@vanadiy:~/vladimir-bobko$ ls -la ./.github/worklows/
	total 224
	drwxrwxr-x 2 vanadiy vanadiy   4096 Jul 27 14:50 .
	drwxrwxr-x 3 vanadiy vanadiy   4096 Jul 27 14:17 ..
	-rw-rw-r-- 1 vanadiy vanadiy 220898 Jul 27 14:03 validate-shell.yaml
	vanadiy@vanadiy:~/vladimir-bobko$ git add .github/
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is behind 'origin/main' by 2 commits, and can be fast-forwarded.
	  (use "git pull" to update your local branch)
	
	Changes to be committed:
	  (use "git restore --staged <file>..." to unstage)
		new file:   .github/workflows/validate-shell.yaml
	
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -m "Add .yaml"
	[main 33d1168] Add .yaml
	 1 file changed, 1341 insertions(+)
	 create mode 100644 .github/worklows/validate-shell.yaml
	vanadiy@vanadiy:~/vladimir-bobko$ git push origin main
	Enumerating objects: 9, done.
	Counting objects: 100% (9/9), done.
	Delta compression using up to 4 threads
	Compressing objects: 100% (5/5), done.
	Writing objects: 100% (8/8), 105.12 KiB | 1.59 MiB/s, done.
	Total 8 (delta 2), reused 0 (delta 0), pack-reused 0
	remote: Resolving deltas: 100% (2/2), completed with 1 local object.
	To github.com:tms-dos17-onl/vladimir-bobko.git
	   b09f34e..f1c1b7c  main -> main
---
## Создать из ветки main ветку develop. Переключиться на неё и создать README.md в корне репозитория. Написать в этом файле какие инструменты DevOps вам знакомы и с какими вы бы хотели познакомиться больше всего (2-3 пункта).
---
	vanadiy@vanadiy:~/vladimir-bobko$ git branch develop
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout develop
	Switched to branch 'develop'
	vanadiy@vanadiy:~/vladimir-bobko$ nano README.md
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -am "Add file branch develop"
	[develop 9d7f6b0] Add file branch develop
	 1 file changed, 4 insertions(+)
	vanadiy@vanadiy:~/vladimir-bobko$ git push origin develop
	Enumerating objects: 5, done.
	Counting objects: 100% (5/5), done.
	Delta compression using up to 4 threads
	Compressing objects: 100% (3/3), done.
	Writing objects: 100% (3/3), 497 bytes | 497.00 KiB/s, done.
	Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
	remote: Resolving deltas: 100% (1/1), completed with 1 local object.
	remote: 
	remote: Create a pull request for 'develop' on GitHub by visiting:
	remote:      https://github.com/tms-dos17-onl/vladimir-bobko/pull/new/develop
	remote: 
	To github.com:tms-dos17-onl/vladimir-bobko.git
	 * [new branch]      develop -> develop
	 > warning Для выполнения задания использовать Markdown, а именно заголовок и списки
---
## Создать из ветки main ветку support и создать там файлик LICENSE с содержимым <https://www.apache.org/licenses/LICENSE-2.0.txt>. Создать коммит. Вывести последниe 3 коммитa.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout main
	Switched to branch 'main'
	Your branch is up to date with 'origin/main'.
	vanadiy@vanadiy:~/vladimir-bobko$ git branch support
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout support
	Switched to branch 'support'
	vanadiy@vanadiy:~/vladimir-bobko$ curl https://www.apache.org/licenses/LICENSE-2.0.txt > LICENSE
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100 11358  100 11358    0     0  39383      0 --:--:-- --:--:-- --:--:-- 39301
	vanadiy@vanadiy:~/vladimir-bobko$ git add LICENSE 
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -m "Add file branch support"
	[support 817f508] Add file branch support
	 1 file changed, 202 insertions(+)
	 create mode 100644 LICENSE
	vanadiy@vanadiy:~/vladimir-bobko$ git log -3
	commit 817f5081846601103f3c7ec2cc585526892bc584 (HEAD -> support)
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 16:05:03 2023 +0300
	
	    Add file branch support
	
	commit f1c1b7c1ab37d26686e56c7e98e8f0e8dfd2dba2 (origin/main, origin/HEAD, main)
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 15:20:51 2023 +0300
	
	    Add .yaml
	
	commit 77147b3915245534b2f09e5972b4e95188b9bddc
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 15:10:08 2023 +0300
	
	    Add file README
	vanadiy@vanadiy:~/vladimir-bobko$ git push origin support
	Enumerating objects: 4, done.
	Counting objects: 100% (4/4), done.
	Delta compression using up to 4 threads
	Compressing objects: 100% (3/3), done.
	Writing objects: 100% (3/3), 4.13 KiB | 2.06 MiB/s, done.
	Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
	remote: Resolving deltas: 100% (1/1), completed with 1 local object.
	remote: 
	remote: Create a pull request for 'support' on GitHub by visiting:
	remote:      https://github.com/tms-dos17-onl/vladimir-bobko/pull/new/support
	remote: 
	To github.com:tms-dos17-onl/vladimir-bobko.git
	 * [new branch]      support -> support
---
## Переключиться обратно на ветку main и создать там файлик LICENSE с содержимым <https://github.com/git/git-scm.com/blob/main/MIT-LICENSE.txt>. Создать коммит. Вывести последниe 3 коммитa.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout main
	Switched to branch 'main'
	Your branch is up to date with 'origin/main'.
	vanadiy@vanadiy:~/vladimir-bobko$ curl https://github.com/git/git-scm.com/blob/main/MIT-LICENSE.txt > LICENSE
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100  6656  100  6656    0     0   7071      0 --:--:-- --:--:-- --:--:--  7073
	vanadiy@vanadiy:~/vladimir-bobko$ git add LICENSE 
	vanadiy@vanadiy:~/vladimir-bobko$ git commit -m "Add file branch main"
	[main 27b2cdc] Add file branch main
	 1 file changed, 1 insertion(+)
	 create mode 100644 LICENSE
	vanadiy@vanadiy:~/vladimir-bobko$ git log -3
	commit 27b2cdce0e892461dbae66eba11a1fb1e320be8a (HEAD -> main)
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 16:10:36 2023 +0300
	
	    Add file branch main
	
	commit f1c1b7c1ab37d26686e56c7e98e8f0e8dfd2dba2 (origin/main, origin/HEAD)
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 15:20:51 2023 +0300
	
	    Add .yaml
	
	commit 77147b3915245534b2f09e5972b4e95188b9bddc
	Author: Vladimir Bobko <babaika.ko@gmail.com>
	Date:   Thu Jul 27 15:10:08 2023 +0300
	
	    Add file README
	vanadiy@vanadiy:~/vladimir-bobko$ git push origin main
	Enumerating objects: 4, done.
	Counting objects: 100% (4/4), done.
	Delta compression using up to 4 threads
	Compressing objects: 100% (3/3), done.
	Writing objects: 100% (3/3), 2.76 KiB | 2.76 MiB/s, done.
	Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
	remote: Resolving deltas: 100% (1/1), completed with 1 local object.
	To github.com:tms-dos17-onl/vladimir-bobko.git
	   f1c1b7c..27b2cdc  main -> main
## Сделать merge ветки support в ветку main и решить конфликты путем выбора содержимого только одной лицензии.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git merge support
	Auto-merging LICENSE
	CONFLICT (add/add): Merge conflict in LICENSE
	Automatic merge failed; fix conflicts and then commit the result.
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is up to date with 'origin/main'.
	
	You have unmerged paths.
	  (fix conflicts and run "git commit")
	  (use "git merge --abort" to abort the merge)
	
	Unmerged paths:
	  (use "git add <file>..." to mark resolution)
		both added:      LICENSE
	
	no changes added to commit (use "git add" and/or "git commit -a")
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout --ours LICENSE
	Updated 1 path from the index
	vanadiy@vanadiy:~/vladimir-bobko$ git add LICENSE
	vanadiy@vanadiy:~/vladimir-bobko$ git status
	On branch main
	Your branch is up to date with 'origin/main'.
	
	All conflicts fixed but you are still merging.
	  (use "git commit" to conclude merge)
	
	vanadiy@vanadiy:~/vladimir-bobko$ git merge --continue
	[main f2998ab] Merge branch 'support' Conflict!!!!!
---
## Переключиться на ветку develop и сделать rebase относительно ветки main.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git checkout develop
	Switched to branch 'develop'
	vanadiy@vanadiy:~/vladimir-bobko$ git rebase main
	Successfully rebased and updated refs/heads/develop.
---
## Вывести историю последних 10 коммитов в виде графа с помощью команды git log -10 --oneline --graph.
---
	vanadiy@vanadiy:~/vladimir-bobko$ git log -10 --oneline --graph
	* d9231a3 (HEAD -> develop) Add file branch develop
	*   f2998ab (main) Merge branch 'support' Conflict!!!!!
	|\  
	| * 817f508 (origin/support, support) Add file branch support
	* | 27b2cdc (origin/main, origin/HEAD) Add file branch main
	|/  
	* f1c1b7c Add .yaml
	* 77147b3 Add file README
	* b09f34e Add files via upload
	* 3cc8084 Create readme
	* 4977bf6 Add files via upload
	* dd6138c Create readme
---
## Запушить ветку develop. В истории коммитов должен быть мерж support -> main
---
	vanadiy@vanadiy:~/vladimir-bobko$ git push -f origin develop
	Enumerating objects: 8, done.
	Counting objects: 100% (7/7), done.
	Delta compression using up to 4 threads
	Compressing objects: 100% (4/4), done.
	Writing objects: 100% (4/4), 707 bytes | 707.00 KiB/s, done.
	Total 4 (delta 1), reused 0 (delta 0), pack-reused 0
	remote: Resolving deltas: 100% (1/1), completed with 1 local object.
	To github.com:tms-dos17-onl/vladimir-bobko.git
	 + 9d7f6b0...d9231a3 develop -> develop (forced update)
---
## Зайти в свой репозиторий на GitHub и создать Pull Request из ветки develop в ветку main.
---
	done
---
