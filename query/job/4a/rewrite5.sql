create or replace view aggView5350574497272228464 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8100578930284126338 as select movie_id as v14 from movie_keyword as mk, aggView5350574497272228464 where mk.keyword_id=aggView5350574497272228464.v3;
create or replace view aggView74957073170951312 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4939297694538434110 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView74957073170951312 where mi_idx.info_type_id=aggView74957073170951312.v1 and info>'5.0';
create or replace view aggView4228125728124891199 as select v14, MIN(v9) as v26 from aggJoin4939297694538434110 group by v14;
create or replace view aggJoin1166568421257889903 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4228125728124891199 where t.id=aggView4228125728124891199.v14 and production_year>2005;
create or replace view aggView437663689680722822 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin1166568421257889903 group by v14;
create or replace view aggJoin1181943987119586296 as select v26, v27 from aggJoin8100578930284126338 join aggView437663689680722822 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1181943987119586296;
