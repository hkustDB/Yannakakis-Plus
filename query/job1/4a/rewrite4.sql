create or replace view aggView555971903597855634 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8181579691634284805 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView555971903597855634 where mi_idx.info_type_id=aggView555971903597855634.v1 and info>'5.0';
create or replace view aggView518798679503662128 as select v14, MIN(v9) as v26 from aggJoin8181579691634284805 group by v14;
create or replace view aggJoin3807386694762010712 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView518798679503662128 where t.id=aggView518798679503662128.v14 and production_year>2005;
create or replace view aggView8916200343765502754 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin3807386694762010712 group by v14,v26;
create or replace view aggJoin9209379322751259875 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8916200343765502754 where mk.movie_id=aggView8916200343765502754.v14;
create or replace view aggView7065511112424067408 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4035018464874164020 as select v26, v27 from aggJoin9209379322751259875 join aggView7065511112424067408 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4035018464874164020;
