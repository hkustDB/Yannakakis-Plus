create or replace view aggView2641867283806555169 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3281754869495439729 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView2641867283806555169 where mc.movie_id=aggView2641867283806555169.v12;
create or replace view aggView1686672221359646720 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin3933597128627112431 as select v12, v31 from aggJoin3281754869495439729 join aggView1686672221359646720 using(v1);
create or replace view aggView1210282268739375231 as select v12, MIN(v31) as v31 from aggJoin3933597128627112431 group by v12,v31;
create or replace view aggJoin4012669708884771186 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1210282268739375231 where mk.movie_id=aggView1210282268739375231.v12;
create or replace view aggView6635281947004571977 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6630853895618222790 as select v31 from aggJoin4012669708884771186 join aggView6635281947004571977 using(v18);
select MIN(v31) as v31 from aggJoin6630853895618222790;
