create or replace view aggView6650919265916689361 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4527554931272613893 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6650919265916689361 where mc.company_type_id=aggView6650919265916689361.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1373820471825330351 as select v15, MIN(v9) as v27 from aggJoin4527554931272613893 group by v15;
create or replace view aggJoin1182337105668318688 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView1373820471825330351 where mi_idx.movie_id=aggView1373820471825330351.v15;
create or replace view aggView5299857024151797698 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin158041460283011191 as select v15, v27 from aggJoin1182337105668318688 join aggView5299857024151797698 using(v3);
create or replace view aggView3425704562501985712 as select v15, MIN(v27) as v27 from aggJoin158041460283011191 group by v15;
create or replace view aggJoin3530420535112542660 as select title as v16, production_year as v19, v27 from title as t, aggView3425704562501985712 where t.id=aggView3425704562501985712.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin3530420535112542660;
