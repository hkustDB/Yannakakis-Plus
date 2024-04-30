create or replace view aggView4359002106620685286 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7797460478195888488 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4359002106620685286 where mc.company_type_id=aggView4359002106620685286.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView1009867752622469569 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5802956141693391650 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1009867752622469569 where mi_idx.info_type_id=aggView1009867752622469569.v3;
create or replace view aggView2026778982929048229 as select v15 from aggJoin5802956141693391650 group by v15;
create or replace view aggJoin4674970340127519020 as select v15, v9 from aggJoin7797460478195888488 join aggView2026778982929048229 using(v15);
create or replace view aggView5784368921517590804 as select v15, MIN(v9) as v27 from aggJoin4674970340127519020 group by v15;
create or replace view aggJoin1716251430587542835 as select title as v16, production_year as v19, v27 from title as t, aggView5784368921517590804 where t.id=aggView5784368921517590804.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1716251430587542835;
