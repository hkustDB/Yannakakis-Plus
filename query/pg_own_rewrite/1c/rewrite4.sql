create or replace view aggView6489504719566600008 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin3625651852368380622 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6489504719566600008 where mc.movie_id=aggView6489504719566600008.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4821262708435338632 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2950574863629472597 as select v15, v9, v28, v29 from aggJoin3625651852368380622 join aggView4821262708435338632 using(v1);
create or replace view aggView5069682794526431141 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2950574863629472597 group by v15,v28,v29;
create or replace view aggJoin3447912271712490145 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView5069682794526431141 where mi_idx.movie_id=aggView5069682794526431141.v15;
create or replace view aggView1666215774948740906 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8097589245555636487 as select v28, v29, v27 from aggJoin3447912271712490145 join aggView1666215774948740906 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8097589245555636487;
