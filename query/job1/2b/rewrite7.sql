create or replace view aggView208566150182870424 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4856724304366584235 as select movie_id as v12 from movie_companies as mc, aggView208566150182870424 where mc.company_id=aggView208566150182870424.v1;
create or replace view aggView6481696447151378071 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7072401678160254169 as select movie_id as v12 from movie_keyword as mk, aggView6481696447151378071 where mk.keyword_id=aggView6481696447151378071.v18;
create or replace view aggView387639579999749390 as select v12 from aggJoin7072401678160254169 group by v12;
create or replace view aggJoin7392226783019673612 as select v12 from aggJoin4856724304366584235 join aggView387639579999749390 using(v12);
create or replace view aggView3264876269777711578 as select v12 from aggJoin7392226783019673612 group by v12;
create or replace view aggJoin2601776757703131279 as select title as v20 from title as t, aggView3264876269777711578 where t.id=aggView3264876269777711578.v12;
select MIN(v20) as v31 from aggJoin2601776757703131279;
