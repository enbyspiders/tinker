module.exports = function(eleventyConfig) {

	eleventyConfig.addPassthroughCopy('schematics/**/*.{jpg,jpeg,png,gif}');
  
    eleventyConfig.addPassthroughCopy("assets/");
	
	const slugify = require("slugify");
	eleventyConfig.addFilter("slug", (input) => {
	  const options = {
	    replacement: "-",
	    remove: /[\/&,+()$~%.'":*?<>{}]/g,
	    lower: true
	  };
	  return slugify(input, options);
	});
  
    return {
    
	    dir: {
	      input: ".",
	      includes: "_includes",
	      output: "_site",
	    }
    };
  
};

