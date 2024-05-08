create or replace view aggView6595956518304583133 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin627592979290565817 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6595956518304583133 where mk.movie_id=aggView6595956518304583133.v14;
create or replace view aggView7934460583912977051 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1803367926074141738 as select v14, v27 from aggJoin627592979290565817 join aggView7934460583912977051 using(v3);
create or replace view aggView4150528655378180287 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin567336387849200172 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4150528655378180287 where mi_idx.info_type_id=aggView4150528655378180287.v1 and info>'5.0';
create or replace view aggView4568727771597818098 as select v14, MIN(v9) as v26 from aggJoin567336387849200172 group by v14;
create or replace view aggJoin4097087624902611019 as select v27 as v27, v26 from aggJoin1803367926074141738 join aggView4568727771597818098 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4097087624902611019;
