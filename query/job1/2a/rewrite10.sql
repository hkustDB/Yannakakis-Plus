create or replace view aggView3878655422968724583 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin3512681518571417213 as select movie_id as v12 from movie_companies as mc, aggView3878655422968724583 where mc.company_id=aggView3878655422968724583.v1;
create or replace view aggView3557125392617335555 as select v12 from aggJoin3512681518571417213 group by v12;
create or replace view aggJoin5254743032789569977 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView3557125392617335555 where mk.movie_id=aggView3557125392617335555.v12;
create or replace view aggView4936190895234948325 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5217438691972528023 as select v12 from aggJoin5254743032789569977 join aggView4936190895234948325 using(v18);
create or replace view aggView1940823807213829569 as select v12 from aggJoin5217438691972528023 group by v12;
create or replace view aggJoin8818038050569360357 as select title as v20 from title as t, aggView1940823807213829569 where t.id=aggView1940823807213829569.v12;
select MIN(v20) as v31 from aggJoin8818038050569360357;
