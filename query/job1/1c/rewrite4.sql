create or replace view aggView6960065712518011342 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2268115033187697718 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6960065712518011342 where mi_idx.info_type_id=aggView6960065712518011342.v3;
create or replace view aggView3945839311347455784 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin81494534962788764 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3945839311347455784 where mc.company_type_id=aggView3945839311347455784.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4293318564053614517 as select v15, MIN(v9) as v27 from aggJoin81494534962788764 group by v15;
create or replace view aggJoin4377188411507425448 as select v15, v27 from aggJoin2268115033187697718 join aggView4293318564053614517 using(v15);
create or replace view aggView1827808738924690256 as select v15, MIN(v27) as v27 from aggJoin4377188411507425448 group by v15;
create or replace view aggJoin7168290314709371734 as select title as v16, production_year as v19, v27 from title as t, aggView1827808738924690256 where t.id=aggView1827808738924690256.v15 and production_year>2010;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7168290314709371734;
