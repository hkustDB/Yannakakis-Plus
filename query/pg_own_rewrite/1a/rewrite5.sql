create or replace view aggView7875264527545485502 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6171277068919094588 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7875264527545485502 where mc.company_type_id=aggView7875264527545485502.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView7757233058056953509 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8996342646835267872 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7757233058056953509 where mi_idx.info_type_id=aggView7757233058056953509.v3;
create or replace view aggView5819782223327640905 as select v15, MIN(v9) as v27 from aggJoin6171277068919094588 group by v15;
create or replace view aggJoin1764010041359184852 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView5819782223327640905 where t.id=aggView5819782223327640905.v15;
create or replace view aggView2062753324657963543 as select v15 from aggJoin8996342646835267872 group by v15;
create or replace view aggJoin1491159489842658716 as select v16, v19, v27 as v27 from aggJoin1764010041359184852 join aggView2062753324657963543 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1491159489842658716;
