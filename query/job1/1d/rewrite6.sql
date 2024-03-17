create or replace view aggView8966105335376639865 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin6273124814002627625 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8966105335376639865 where mc.movie_id=aggView8966105335376639865.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6816622091167276854 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8811803233849830946 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6816622091167276854 where mi_idx.info_type_id=aggView6816622091167276854.v3;
create or replace view aggView1615108082372409962 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4746354609394818300 as select v15, v9, v28, v29 from aggJoin6273124814002627625 join aggView1615108082372409962 using(v1);
create or replace view aggView6517490249631108166 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin4746354609394818300 group by v15;
create or replace view aggJoin5355331465161762470 as select v28, v29, v27 from aggJoin8811803233849830946 join aggView6517490249631108166 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5355331465161762470;
