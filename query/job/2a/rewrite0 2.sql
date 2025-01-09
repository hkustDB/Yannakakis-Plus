create or replace view aggView5866594672265067978 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2279468779045513435 as select movie_id as v12 from movie_keyword as mk, aggView5866594672265067978 where mk.keyword_id=aggView5866594672265067978.v18;
create or replace view aggView8896469986901645275 as select v12 from aggJoin2279468779045513435 group by v12;
create or replace view aggJoin6256778549746488410 as select id as v12, title as v20 from title as t, aggView8896469986901645275 where t.id=aggView8896469986901645275.v12;
create or replace view aggView1632443120709274616 as select v12, MIN(v20) as v31 from aggJoin6256778549746488410 group by v12;
create or replace view aggJoin6424751560011875450 as select company_id as v1, v31 from movie_companies as mc, aggView1632443120709274616 where mc.movie_id=aggView1632443120709274616.v12;
create or replace view aggView2988905438479116500 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin1376717656654163305 as select v31 from aggJoin6424751560011875450 join aggView2988905438479116500 using(v1);
select MIN(v31) as v31 from aggJoin1376717656654163305;
