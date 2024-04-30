create or replace view aggView5648609806395169578 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2230268317037649767 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5648609806395169578 where mi_idx.info_type_id=aggView5648609806395169578.v3;
create or replace view aggView2036766153740286473 as select v15 from aggJoin2230268317037649767 group by v15;
create or replace view aggJoin8529088761891437027 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2036766153740286473 where mc.movie_id=aggView2036766153740286473.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7197430896581009305 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7086381752081953552 as select v15, v9 from aggJoin8529088761891437027 join aggView7197430896581009305 using(v1);
create or replace view aggView5398699035558747093 as select v15, MIN(v9) as v27 from aggJoin7086381752081953552 group by v15;
create or replace view aggJoin1659393666438196364 as select title as v16, production_year as v19, v27 from title as t, aggView5398699035558747093 where t.id=aggView5398699035558747093.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1659393666438196364;
