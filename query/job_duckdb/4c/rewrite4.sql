create or replace view aggView1501160874971814431 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1209065120849200081 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1501160874971814431 where mi_idx.info_type_id=aggView1501160874971814431.v1 and info>'2.0';
create or replace view aggView558519715464873933 as select v14, MIN(v9) as v26 from aggJoin1209065120849200081 group by v14;
create or replace view aggJoin7354675738541914568 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView558519715464873933 where t.id=aggView558519715464873933.v14 and production_year>1990;
create or replace view aggView4491764693995211882 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2152792956681600596 as select movie_id as v14 from movie_keyword as mk, aggView4491764693995211882 where mk.keyword_id=aggView4491764693995211882.v3;
create or replace view aggView3261620167547969457 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7354675738541914568 group by v14,v26;
create or replace view aggJoin2639300710078373237 as select v26, v27 from aggJoin2152792956681600596 join aggView3261620167547969457 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2639300710078373237;
