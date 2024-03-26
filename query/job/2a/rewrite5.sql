create or replace view aggView1373710657207327423 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4340904182182655297 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1373710657207327423 where mc.movie_id=aggView1373710657207327423.v12;
create or replace view aggView8630884010301491597 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3812171290231636378 as select movie_id as v12 from movie_keyword as mk, aggView8630884010301491597 where mk.keyword_id=aggView8630884010301491597.v18;
create or replace view aggView8024789889650612742 as select v12 from aggJoin3812171290231636378 group by v12;
create or replace view aggJoin6583045127970144755 as select v1, v31 as v31 from aggJoin4340904182182655297 join aggView8024789889650612742 using(v12);
create or replace view aggView2170253459874970315 as select v1, MIN(v31) as v31 from aggJoin6583045127970144755 group by v1;
create or replace view aggJoin6337558539289188372 as select country_code as v3, v31 from company_name as cn, aggView2170253459874970315 where cn.id=aggView2170253459874970315.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin6337558539289188372;
