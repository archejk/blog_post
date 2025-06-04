taylor = User.create!(name: "Taylor Swift", email: "taylorsheesh@example.com", password: "password")
joe = User.create!(name: "Joe Alwyn", email: "joealwyn@example.com", password: "password")


BlogPost.create!(
  title: "The Art of Staying Consistent as a Developer",
  content: "Staying consistent isn't about working nonstop, it's about showing up regularly and making small progress every day. Whether it's coding, writing, or learning something new, consistency is the quiet strength that keeps your growth on track. :))))))))",
  author: taylor
)

BlogPost.create!(
  title: "Git Commit Messages Matter",
  content: "A good commit message is a love letter to your future self. Write clear, write often.",
  author: taylor
)

BlogPost.create!(
  title: "Learning by Breaking Things",
  content: "I learn best when I mess up, then figure out why. Breaking things is part of building things.",
  author: taylor
)

BlogPost.create!(
  title: "Dark Mode Saved My Eyes",
  content: "Bright white screens at midnight? Never again. Long live dark mode. 🌓",
  author: joe
)

BlogPost.create!(
  title: "My First Pull Request",
  content: "It was small — a typo fix — but it was my first PR to an open-source repo. Felt amazing.",
  author: joe
)

BlogPost.create!(
  title: "Console Logs are My Best Friend",
  content: "When in doubt, puts it out. Debugging gets easier when you talk to your code.",
  author: taylor
)
