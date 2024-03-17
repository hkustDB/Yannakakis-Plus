create or replace view aggView7274051954391584013 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8740324453117246865 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView7274051954391584013 where mk.movie_id=aggView7274051954391584013.v14;
create or replace view aggView156638627382300681 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3690556278003321489 as select v14, v27 from aggJoin8740324453117246865 join aggView156638627382300681 using(v3);
create or replace view aggView5022555278645789306 as select v14, MIN(v27) as v27 from aggJoin3690556278003321489 group by v14;
create or replace view aggJoin4125070137739338022 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5022555278645789306 where mi_idx.movie_id=aggView5022555278645789306.v14 and info>'5.0';
create or replace view aggView6902691479278682873 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1190437325664117 as select v9, v27 from aggJoin4125070137739338022 join aggView6902691479278682873 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin1190437325664117;
