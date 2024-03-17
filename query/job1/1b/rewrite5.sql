create or replace view aggView9138165879813419719 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3646539854083833321 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9138165879813419719 where mc.company_type_id=aggView9138165879813419719.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3953725690418077195 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3596135582955662660 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3953725690418077195 where mi_idx.info_type_id=aggView3953725690418077195.v3;
create or replace view aggView3956572508450774991 as select v15 from aggJoin3596135582955662660 group by v15;
create or replace view aggJoin8560104880122174322 as select v15, v9 from aggJoin3646539854083833321 join aggView3956572508450774991 using(v15);
create or replace view aggView4356382418825757201 as select v15, MIN(v9) as v27 from aggJoin8560104880122174322 group by v15;
create or replace view aggJoin2088342582278613224 as select title as v16, production_year as v19, v27 from title as t, aggView4356382418825757201 where t.id=aggView4356382418825757201.v15 and production_year<=2010 and production_year>=2005;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2088342582278613224;
