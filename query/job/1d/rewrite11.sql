create or replace view aggView4131511922985061672 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin1155526126035276204 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4131511922985061672 where mc.movie_id=aggView4131511922985061672.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6286762022331935158 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7577765784139220830 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6286762022331935158 where mi_idx.info_type_id=aggView6286762022331935158.v3;
create or replace view aggView8691439205287545376 as select v15 from aggJoin7577765784139220830 group by v15;
create or replace view aggJoin1435872525391587741 as select v1, v9, v28 as v28, v29 as v29 from aggJoin1155526126035276204 join aggView8691439205287545376 using(v15);
create or replace view aggView2251811710118751508 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3422521312907786092 as select v9, v28, v29 from aggJoin1435872525391587741 join aggView2251811710118751508 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3422521312907786092;
