create or replace view aggView5330709349274160389 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8132770396508770063 as select movie_id as v12 from movie_keyword as mk, aggView5330709349274160389 where mk.keyword_id=aggView5330709349274160389.v1;
create or replace view aggView390108910604196389 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin6283046867325372013 as select id as v12, title as v13, production_year as v16 from title as t, aggView390108910604196389 where t.id=aggView390108910604196389.v12 and production_year>2010;
create or replace view aggView1822257133828078811 as select v12 from aggJoin8132770396508770063 group by v12;
create or replace view aggJoin7735869851719623064 as select v13, v16 from aggJoin6283046867325372013 join aggView1822257133828078811 using(v12);
create or replace view aggView8687283985584770124 as select v13 from aggJoin7735869851719623064;
select MIN(v13) as v24 from aggView8687283985584770124;
