create or replace view aggView5514796472818535554 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7782529086109513047 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5514796472818535554 where mi_idx.info_type_id=aggView5514796472818535554.v1 and info>'5.0';
create or replace view aggView7638035890026558929 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin4852075877599186585 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView7638035890026558929 where mk.movie_id=aggView7638035890026558929.v14;
create or replace view aggView2266327996280778309 as select v14, MIN(v9) as v26 from aggJoin7782529086109513047 group by v14;
create or replace view aggJoin3770199928532094587 as select v3, v27 as v27, v26 from aggJoin4852075877599186585 join aggView2266327996280778309 using(v14);
create or replace view aggView2810165517317369836 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3612158437824923666 as select v27, v26 from aggJoin3770199928532094587 join aggView2810165517317369836 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3612158437824923666;
