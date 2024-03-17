create or replace view aggView3819700294905684120 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5422898257374260452 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3819700294905684120 where mi_idx.info_type_id=aggView3819700294905684120.v3;
create or replace view aggView1581396209692367845 as select v15 from aggJoin5422898257374260452 group by v15;
create or replace view aggJoin1483124423963980866 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView1581396209692367845 where mc.movie_id=aggView1581396209692367845.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView475932872691885168 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1790106319401009785 as select v15, v9 from aggJoin1483124423963980866 join aggView475932872691885168 using(v1);
create or replace view aggView943330167141453850 as select v15, MIN(v9) as v27 from aggJoin1790106319401009785 group by v15;
create or replace view aggJoin1094738788297965675 as select title as v16, production_year as v19, v27 from title as t, aggView943330167141453850 where t.id=aggView943330167141453850.v15 and production_year>2010;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1094738788297965675;
