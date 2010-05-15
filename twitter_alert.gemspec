# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter_alert}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Hamill"]
  s.date = %q{2010-05-14}
  s.description = %q{Create messages, assign a time, then DM all Followers of a Twitter account with those messages as the assigned time.}
  s.email = %q{twitteralert@benhamill.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "doc/LICENSE.html",
     "doc/README_rdoc.html",
     "doc/TwitterAlert.html",
     "doc/TwitterAlert/Account.html",
     "doc/TwitterAlert/Alert.html",
     "doc/created.rid",
     "doc/images/brick.png",
     "doc/images/brick_link.png",
     "doc/images/bug.png",
     "doc/images/bullet_black.png",
     "doc/images/bullet_toggle_minus.png",
     "doc/images/bullet_toggle_plus.png",
     "doc/images/date.png",
     "doc/images/find.png",
     "doc/images/loadingAnimation.gif",
     "doc/images/macFFBgHack.png",
     "doc/images/package.png",
     "doc/images/page_green.png",
     "doc/images/page_white_text.png",
     "doc/images/page_white_width.png",
     "doc/images/plugin.png",
     "doc/images/ruby.png",
     "doc/images/tag_green.png",
     "doc/images/wrench.png",
     "doc/images/wrench_orange.png",
     "doc/images/zoom.png",
     "doc/index.html",
     "doc/js/darkfish.js",
     "doc/js/jquery.js",
     "doc/js/quicksearch.js",
     "doc/js/thickbox-compressed.js",
     "doc/lib/twitter_alert/account_rb.html",
     "doc/lib/twitter_alert/alert_rb.html",
     "doc/lib/twitter_alert_rb.html",
     "doc/rdoc.css",
     "lib/twitter_alert.rb",
     "lib/twitter_alert/account.rb",
     "lib/twitter_alert/alert.rb",
     "test/helper.rb",
     "test/test_account.rb",
     "test/test_alert.rb",
     "twitter_alert.gemspec"
  ]
  s.homepage = %q{http://github.com/BenHamill/twitter_alert}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Send scheduled Direct Messages to all Twitter Followers.}
  s.test_files = [
    "test/helper.rb",
     "test/test_account.rb",
     "test/test_alert.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_runtime_dependency(%q<grackle>, [">= 0.1.9"])
    else
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_dependency(%q<grackle>, [">= 0.1.9"])
    end
  else
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    s.add_dependency(%q<grackle>, [">= 0.1.9"])
  end
end

