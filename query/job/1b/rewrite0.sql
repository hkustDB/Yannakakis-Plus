create or replace view aggView2042869480061575752 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8079370983280105981 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2042869480061575752 where mi_idx.info_type_id=aggView2042869480061575752.v3;
create or replace view aggView9008951777429861850 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6811100105584258754 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9008951777429861850 where mc.company_type_id=aggView9008951777429861850.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7284014980680366065 as select v15 from aggJoin8079370983280105981 group by v15;
create or replace view aggJoin8616114974663872287 as select id as v15, title as v16, production_year as v19 from title as t, aggView7284014980680366065 where t.id=aggView7284014980680366065.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6061147985307668189 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8616114974663872287 group by v15;
create or replace view aggJoin4509969464849654762 as select v9, v28, v29 from aggJoin6811100105584258754 join aggView6061147985307668189 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4509969464849654762;
