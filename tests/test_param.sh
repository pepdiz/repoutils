
test_h_or_help_show_syntax () {
  OUT='repo-gen [dir] [repo-name]

creates a repository in folder dir with name repo-name
default: dir is current dir and repo-name is dir name'

  assert_equals "$OUT"  "$(../repo-gen -h)"
  assert_equals "$OUT"  "$(../repo-gen --help)"
}

test_h_or_help_exit_with_success () {
  assert_status_code 0 ../repo-gen -h 
  assert_status_code 0 ../repo-gen --help 
}

todo_other_flags_exit_with_error () {
  fail "not implemented"
}

test_dir_passed_is_invalid_dir () {
  DIR=./non_existent_dir
  assert_equals "$DIR is not a directory" "$(../repo-gen $DIR)"
}

test_when_invalid_dir_should_fail_with_code_1 () {
  DIR=./non_existent_dir
  assert_status_code 1 "../repo-gen $DIR"
}

test_non_passing_repo_name_makes_it_dir_name () {
  DIR=$(mktemp -d)
  DIRNAME=$(basename $DIR)
  ../repo-gen $DIR
  assert_matches ".*$DIRNAME Porteus repository.*" "$(cat $DIR/index.html)"
  rm -rf $DIR
}

test_passing_repo_name_uses_it () {
  DIR=$(mktemp -d)
  REPONAME=mi_repo
  ../repo-gen $DIR $REPONAME
  assert_matches ".*$REPONAME Porteus repository.*" "$(cat $DIR/index.html)"
  rm -rf $DIR
}
