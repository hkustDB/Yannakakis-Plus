create or replace view aggView4873895515861497165 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2584429006652869583 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4873895515861497165 where mi_idx.info_type_id=aggView4873895515861497165.v3;
create or replace view aggView1539253701305009473 as select v15 from aggJoin2584429006652869583 group by v15;
create or replace view aggJoin1477331477629982896 as select id as v15, title as v16, production_year as v19 from title as t, aggView1539253701305009473 where t.id=aggView1539253701305009473.v15 and production_year>2010;
create or replace view aggView8640325733532799550 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8514311738269033816 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8640325733532799550 where mc.company_type_id=aggView8640325733532799550.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView680342664897981661 as select v15, MIN(v9) as v27 from aggJoin8514311738269033816 group by v15;
create or replace view aggJoin8991716361782787976 as select v16, v19, v27 from aggJoin1477331477629982896 join aggView680342664897981661 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8991716361782787976;
