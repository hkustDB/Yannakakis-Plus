create or replace view aggView9175702899206576554 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin9025837697416634109 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView9175702899206576554 where mi_idx.movie_id=aggView9175702899206576554.v15;
create or replace view aggView5593134189995611635 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin7674619941125864834 as select v15, v28, v29 from aggJoin9025837697416634109 join aggView5593134189995611635 using(v3);
create or replace view aggView4724831274143878340 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin7674619941125864834 group by v15,v28,v29;
create or replace view aggJoin7132214909755332372 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4724831274143878340 where mc.movie_id=aggView4724831274143878340.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3368423212475993860 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8013150399746932921 as select v9, v28, v29 from aggJoin7132214909755332372 join aggView3368423212475993860 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8013150399746932921;
