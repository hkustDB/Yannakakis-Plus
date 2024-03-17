create or replace view aggView2101137669010831200 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin7858627574189041784 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2101137669010831200 where mc.movie_id=aggView2101137669010831200.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView9171745781576112266 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1880859449307279262 as select movie_id as v15 from movie_info_idx as mi_idx, aggView9171745781576112266 where mi_idx.info_type_id=aggView9171745781576112266.v3;
create or replace view aggView4942042532233278279 as select v15 from aggJoin1880859449307279262 group by v15;
create or replace view aggJoin6828149926776892849 as select v1, v9, v28 as v28, v29 as v29 from aggJoin7858627574189041784 join aggView4942042532233278279 using(v15);
create or replace view aggView354557851212645026 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6828149926776892849 group by v1;
create or replace view aggJoin8647856053348414941 as select kind as v2, v28, v29, v27 from company_type as ct, aggView354557851212645026 where ct.id=aggView354557851212645026.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8647856053348414941;
