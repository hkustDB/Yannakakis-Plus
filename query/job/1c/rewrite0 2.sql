create or replace view aggView1681174942790361394 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2530790641231124105 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1681174942790361394 where mi_idx.info_type_id=aggView1681174942790361394.v3;
create or replace view aggView396691611011028476 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1099439192576802081 as select movie_id as v15, note as v9 from movie_companies as mc, aggView396691611011028476 where mc.company_type_id=aggView396691611011028476.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8460911848094479129 as select v15 from aggJoin2530790641231124105 group by v15;
create or replace view aggJoin6391424427147048513 as select v15, v9 from aggJoin1099439192576802081 join aggView8460911848094479129 using(v15);
create or replace view aggView9036989628994642836 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin1163008103368203673 as select v9, v28, v29 from aggJoin6391424427147048513 join aggView9036989628994642836 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1163008103368203673;
