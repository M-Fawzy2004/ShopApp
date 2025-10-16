class CategoryImageMapper {
  // Map each category to a specific high-quality image
  static const Map<String, String> categoryImages = {
    // Beauty & Personal Care
    'beauty':
        'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&q=80',
    'skin-care':
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&q=80',
    'fragrances':
        'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400&q=80',

    // Fashion
    'mens-shirts':
        'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400&q=80',
    'mens-shoes':
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&q=80',
    'womens-dresses':
        'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400&q=80',
    'womens-shoes':
        'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400&q=80',
    'womens-bags':
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&q=80',
    'tops':
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400&q=80',

    // Accessories
    'mens-watches':
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=400&q=80',
    'womens-watches':
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400&q=80',
    'womens-jewellery':
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400&q=80',
    'sunglasses':
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&q=80',

    // Electronics
    'laptops':
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&q=80',
    'smartphones':
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&q=80',
    'tablets':
        'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=400&q=80',
    'mobile-accessories':
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&q=80',

    // Home
    'furniture':
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&q=80',
    'home-decoration':
        'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=400&q=80',
    'kitchen-accessories':
        'https://images.unsplash.com/photo-1556911220-bff31c812dba?w=400&q=80',

    // Other
    'groceries':
        'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80',
    'sports-accessories':
        'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=400&q=80',
    'motorcycle':
        'https://images.unsplash.com/photo-1558981852-426c6c22a060?w=400&q=80',
    'vehicle':
        'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=400&q=80',
  };

  // Fallback image for unknown categories
  static const String fallbackImage =
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&q=80';

  static String getImageUrl(String slug) {
    return categoryImages[slug] ?? fallbackImage;
  }
}
