create or replace view aggView101740377869275731 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin6209038422644810135 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView101740377869275731 where mk.movie_id=aggView101740377869275731.v12;
create or replace view aggView1246051989771243094 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin1075889652741064957 as select v1, v24 as v24 from aggJoin6209038422644810135 join aggView1246051989771243094 using(v12);
create or replace view aggView2716628993613482806 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3974542159622023742 as select v24 from aggJoin1075889652741064957 join aggView2716628993613482806 using(v1);
select MIN(v24) as v24 from aggJoin3974542159622023742;
