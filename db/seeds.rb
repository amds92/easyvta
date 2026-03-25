# Admin user
User.find_or_create_by(email_address: "admin@easyvta.net") do |u|
  u.password = "easyvta2025!"
  u.password_confirmation = "easyvta2025!"
end

puts "Admin criado: admin@easyvta.net / easyvta2025!"

# Products
products = [
  {
    name: "Easy VTA for Rega RB-330",
    slug: "rega-rb-330",
    tonearm_name: "Rega RB-330",
    description: "Designed for the Rega RB-330 tonearm with 3-point armboard fixing.",
    price_pence: 15000,
    shaft_size: nil,
    mounting_type: "3-point fixing",
    stock_status: :in_stock,
    featured: false,
    position: 1
  },
  {
    name: "Easy VTA for Jelco SA-750D & Ortofon AS-309R",
    slug: "jelco-sa-750d",
    tonearm_name: "Jelco SA-750D / Ortofon AS-309R",
    description: "18mm pillar shaft. Also fits the Ortofon AS-309R tonearm.",
    price_pence: 14900,
    shaft_size: "18mm shaft",
    mounting_type: nil,
    stock_status: :in_stock,
    featured: false,
    position: 2
  },
  {
    name: "Easy VTA for Sumiko Premier MMT",
    slug: "sumiko-premier-mmt",
    tonearm_name: "Sumiko Premier MMT",
    description: "16mm pillar shaft. Precision fit for the Sumiko Premier MMT tonearm.",
    price_pence: 14900,
    shaft_size: "16mm shaft",
    mounting_type: nil,
    stock_status: :in_stock,
    featured: false,
    position: 3
  },
  {
    name: "Easy VTA for GrooveMaster",
    slug: "groovemaster",
    tonearm_name: "GrooveMaster (Jelco base)",
    description: "20.5mm shaft. For GrooveMaster tonearms with Jelco base.",
    price_pence: 17500,
    shaft_size: "20.5mm shaft",
    mounting_type: nil,
    stock_status: :in_stock,
    featured: false,
    position: 4
  },
  {
    name: "Easy VTA for Thomas Schick",
    slug: "thomas-schick",
    tonearm_name: "Thomas Schick",
    description: "19mm pillar shaft. Precision-engineered for the Thomas Schick tonearm.",
    price_pence: 17500,
    shaft_size: "19mm shaft",
    mounting_type: nil,
    stock_status: :in_stock,
    featured: false,
    position: 5
  },
  {
    name: "Easy VTA Sliding Mounting Base",
    slug: "sliding-mounting-base",
    tonearm_name: "SME / Sliding Mounting Base",
    description: "20.5mm shaft. Premium sliding design for maximum adjustability.",
    price_pence: 22500,
    shaft_size: "20.5mm shaft",
    mounting_type: nil,
    stock_status: :in_stock,
    featured: true,
    position: 6
  },
  {
    name: "Easy VTA for Clearaudio",
    slug: "clearaudio",
    tonearm_name: "Clearaudio (Satisfy, Unify, Performance)",
    description: "25mm shaft. Compatible with Clearaudio Satisfy, Unify and Performance.",
    price_pence: 23500,
    shaft_size: "25mm shaft",
    mounting_type: nil,
    stock_status: :out_of_stock,
    featured: false,
    position: 7
  },
  {
    name: "Easy VTA for Sorane SA-1.2 / TA-1",
    slug: "sorane-sa-12",
    tonearm_name: "Sorane SA-1.2 / TA-1",
    description: "20mm shaft. For Sorane SA-1.2 and TA-1 tonearms.",
    price_pence: 17500,
    shaft_size: "20mm shaft",
    mounting_type: nil,
    stock_status: :out_of_stock,
    featured: false,
    position: 8
  }
]

products.each do |attrs|
  Product.find_or_create_by(slug: attrs[:slug]) do |p|
    p.assign_attributes(attrs)
  end
end

puts "#{Product.count} produtos criados."
