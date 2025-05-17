-- 향신료
DROP TABLE IF EXISTS spices RESTRICT;

-- 레시피
DROP TABLE IF EXISTS recipes RESTRICT;

-- 풍미 화합물
DROP TABLE IF EXISTS flavor_compounds RESTRICT;

-- 풍미 그룹
DROP TABLE IF EXISTS flavor_groups RESTRICT;

-- 식재료
DROP TABLE IF EXISTS ingredients RESTRICT;

-- 향신료화합물
DROP TABLE IF EXISTS spices_compounds RESTRICT;

-- 궁합식재료
DROP TABLE IF EXISTS blendings_ingredients RESTRICT;

-- 궁합
DROP TABLE IF EXISTS blendings RESTRICT;

-- 레시피재료
DROP TABLE IF EXISTS recipes_ingredients RESTRICT;

-- 레시피향신료
DROP TABLE IF EXISTS recipes_spices RESTRICT;

-- 향신료
CREATE TABLE spices (
  spice_id    INTEGER     NOT NULL, -- 향신료 아이디
  name        VARCHAR(50) NOT NULL, -- 이름
  description MEDIUMTEXT  NOT NULL, -- 설명
  warning     TEXT        NULL,     -- 주의점
  group_id    INTEGER     NOT NULL  -- 그룹 아이디
);

-- 향신료
ALTER TABLE spices
  ADD CONSTRAINT PK_spices -- 향신료 기본키
  PRIMARY KEY (
  spice_id -- 향신료 아이디
  );

-- 향신료 유니크 인덱스
CREATE UNIQUE INDEX UIX_spices
  ON spices ( -- 향신료
    name ASC -- 이름
  );

ALTER TABLE spices
  MODIFY COLUMN spice_id INTEGER NOT NULL AUTO_INCREMENT;

-- 레시피
CREATE TABLE recipes (
  recipe_id INTEGER     NOT NULL, -- 레시피 아이디
  name      VARCHAR(50) NOT NULL  -- 이름
);

-- 레시피
ALTER TABLE recipes
  ADD CONSTRAINT PK_recipes -- 레시피 기본키
  PRIMARY KEY (
  recipe_id -- 레시피 아이디
  );

-- 레시피 유니크 인덱스
CREATE UNIQUE INDEX UIX_recipes
  ON recipes ( -- 레시피
    name ASC -- 이름
  );

ALTER TABLE recipes
  MODIFY COLUMN recipe_id INTEGER NOT NULL AUTO_INCREMENT;

-- 풍미 화합물
CREATE TABLE flavor_compounds (
  compound_id INTEGER     NOT NULL, -- 화합물 아이디
  name        VARCHAR(50) NOT NULL  -- 이름
);

-- 풍미 화합물
ALTER TABLE flavor_compounds
  ADD CONSTRAINT PK_flavor_compounds -- 풍미 화합물 기본키
  PRIMARY KEY (
  compound_id -- 화합물 아이디
  );

-- 풍미 화합물 유니크 인덱스
CREATE UNIQUE INDEX UIX_flavor_compounds
  ON flavor_compounds ( -- 풍미 화합물
    name ASC -- 이름
  );

ALTER TABLE flavor_compounds
  MODIFY COLUMN compound_id INTEGER NOT NULL AUTO_INCREMENT;

-- 풍미 그룹
CREATE TABLE flavor_groups (
  group_id INTEGER     NOT NULL, -- 그룹 아이디
  name     VARCHAR(50) NOT NULL  -- 이름
);

-- 풍미 그룹
ALTER TABLE flavor_groups
  ADD CONSTRAINT PK_flavor_groups -- 풍미 그룹 기본키
  PRIMARY KEY (
  group_id -- 그룹 아이디
  );

-- 풍미 그룹 유니크 인덱스
CREATE UNIQUE INDEX UIX_flavor_groups
  ON flavor_groups ( -- 풍미 그룹
    name ASC -- 이름
  );

ALTER TABLE flavor_groups
  MODIFY COLUMN group_id INTEGER NOT NULL AUTO_INCREMENT;

-- 식재료
CREATE TABLE ingredients (
  ingredient_id INTEGER     NOT NULL, -- 식재료 아이디
  name          VARCHAR(50) NOT NULL  -- 이름
);

-- 식재료
ALTER TABLE ingredients
  ADD CONSTRAINT PK_ingredients -- 식재료 기본키
  PRIMARY KEY (
  ingredient_id -- 식재료 아이디
  );

-- 식재료 유니크 인덱스
CREATE UNIQUE INDEX UIX_ingredients
  ON ingredients ( -- 식재료
    name ASC -- 이름
  );

ALTER TABLE ingredients
  MODIFY COLUMN ingredient_id INTEGER NOT NULL AUTO_INCREMENT;

-- 향신료화합물
CREATE TABLE spices_compounds (
  spice_id    INTEGER NOT NULL, -- 향신료 아이디
  compound_id INTEGER NOT NULL, -- 화합물 아이디
  is_main     BOOLEAN NOT NULL  -- 주요화합물여부
);

-- 향신료화합물
ALTER TABLE spices_compounds
  ADD CONSTRAINT PK_spices_compounds -- 향신료화합물 기본키
  PRIMARY KEY (
  spice_id,    -- 향신료 아이디
  compound_id  -- 화합물 아이디
  );

-- 궁합식재료
CREATE TABLE blendings_ingredients (
  blending_id   INTEGER NOT NULL, -- 궁합아이디
  ingredient_id INTEGER NOT NULL  -- 식재료 아이디
);

-- 궁합식재료
ALTER TABLE blendings_ingredients
  ADD CONSTRAINT PK_blendings_ingredients -- 궁합식재료 기본키
  PRIMARY KEY (
  blending_id,   -- 궁합아이디
  ingredient_id  -- 식재료 아이디
  );

-- 궁합
CREATE TABLE blendings (
  blending_id INTEGER NOT NULL, -- 궁합아이디
  spice_id    INTEGER NOT NULL, -- 향신료 아이디
  description TEXT    NOT NULL  -- 설명
);

-- 궁합
ALTER TABLE blendings
  ADD CONSTRAINT PK_blendings -- 궁합 기본키
  PRIMARY KEY (
  blending_id -- 궁합아이디
  );

ALTER TABLE blendings
  MODIFY COLUMN blending_id INTEGER NOT NULL AUTO_INCREMENT;

-- 레시피재료
CREATE TABLE recipes_ingredients (
  recipe_id     INTEGER NOT NULL, -- 레시피 아이디
  ingredient_id INTEGER NOT NULL, -- 식재료 아이디
  quantity      INTEGER NOT NULL  -- 수량
);

-- 레시피재료
ALTER TABLE recipes_ingredients
  ADD CONSTRAINT PK_recipes_ingredients -- 레시피재료 기본키
  PRIMARY KEY (
  recipe_id,     -- 레시피 아이디
  ingredient_id  -- 식재료 아이디
  );

-- 레시피향신료
CREATE TABLE recipes_spices (
  recipe_id INTEGER NOT NULL, -- 레시피 아이디
  spice_id  INTEGER NOT NULL, -- 향신료 아이디
  quantity  INTEGER NOT NULL  -- 수량
);

-- 레시피향신료
ALTER TABLE recipes_spices
  ADD CONSTRAINT PK_recipes_spices -- 레시피향신료 기본키
  PRIMARY KEY (
  recipe_id, -- 레시피 아이디
  spice_id   -- 향신료 아이디
  );

-- 향신료
ALTER TABLE spices
  ADD CONSTRAINT FK_flavor_groups_TO_spices -- 풍미 그룹 -> 향신료
  FOREIGN KEY (
  group_id -- 그룹 아이디
  )
  REFERENCES flavor_groups ( -- 풍미 그룹
  group_id -- 그룹 아이디
  );

-- 향신료화합물
ALTER TABLE spices_compounds
  ADD CONSTRAINT FK_spices_TO_spices_compounds -- 향신료 -> 향신료화합물
  FOREIGN KEY (
  spice_id -- 향신료 아이디
  )
  REFERENCES spices ( -- 향신료
  spice_id -- 향신료 아이디
  );

-- 향신료화합물
ALTER TABLE spices_compounds
  ADD CONSTRAINT FK_flavor_compounds_TO_spices_compounds -- 풍미 화합물 -> 향신료화합물
  FOREIGN KEY (
  compound_id -- 화합물 아이디
  )
  REFERENCES flavor_compounds ( -- 풍미 화합물
  compound_id -- 화합물 아이디
  );

-- 궁합식재료
ALTER TABLE blendings_ingredients
  ADD CONSTRAINT FK_ingredients_TO_blendings_ingredients -- 식재료 -> 궁합식재료
  FOREIGN KEY (
  ingredient_id -- 식재료 아이디
  )
  REFERENCES ingredients ( -- 식재료
  ingredient_id -- 식재료 아이디
  );

-- 궁합식재료
ALTER TABLE blendings_ingredients
  ADD CONSTRAINT FK_blendings_TO_blendings_ingredients -- 궁합 -> 궁합식재료
  FOREIGN KEY (
  blending_id -- 궁합아이디
  )
  REFERENCES blendings ( -- 궁합
  blending_id -- 궁합아이디
  );

-- 궁합
ALTER TABLE blendings
  ADD CONSTRAINT FK_spices_TO_blendings -- 향신료 -> 궁합
  FOREIGN KEY (
  spice_id -- 향신료 아이디
  )
  REFERENCES spices ( -- 향신료
  spice_id -- 향신료 아이디
  );

-- 레시피재료
ALTER TABLE recipes_ingredients
  ADD CONSTRAINT FK_recipes_TO_recipes_ingredients -- 레시피 -> 레시피재료
  FOREIGN KEY (
  recipe_id -- 레시피 아이디
  )
  REFERENCES recipes ( -- 레시피
  recipe_id -- 레시피 아이디
  );

-- 레시피재료
ALTER TABLE recipes_ingredients
  ADD CONSTRAINT FK_ingredients_TO_recipes_ingredients -- 식재료 -> 레시피재료
  FOREIGN KEY (
  ingredient_id -- 식재료 아이디
  )
  REFERENCES ingredients ( -- 식재료
  ingredient_id -- 식재료 아이디
  );

-- 레시피향신료
ALTER TABLE recipes_spices
  ADD CONSTRAINT FK_recipes_TO_recipes_spices -- 레시피 -> 레시피향신료
  FOREIGN KEY (
  recipe_id -- 레시피 아이디
  )
  REFERENCES recipes ( -- 레시피
  recipe_id -- 레시피 아이디
  );

-- 레시피향신료
ALTER TABLE recipes_spices
  ADD CONSTRAINT FK_spices_TO_recipes_spices -- 향신료 -> 레시피향신료
  FOREIGN KEY (
  spice_id -- 향신료 아이디
  )
  REFERENCES spices ( -- 향신료
  spice_id -- 향신료 아이디
  );