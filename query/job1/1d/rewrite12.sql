create or replace view aggView6990142790845927315 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4081409008170762773 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6990142790845927315 where mc.company_type_id=aggView6990142790845927315.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3465466318519181816 as select v15, MIN(v9) as v27 from aggJoin4081409008170762773 group by v15;
create or replace view aggJoin939908760879111291 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView3465466318519181816 where t.id=aggView3465466318519181816.v15 and production_year>2000;
create or replace view aggView3835978997025901332 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7679115014478237569 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3835978997025901332 where mi_idx.info_type_id=aggView3835978997025901332.v3;
create or replace view aggView5147404093602487343 as select v15 from aggJoin7679115014478237569 group by v15;
create or replace view aggJoin854578528329203861 as select v16, v19, v27 as v27 from aggJoin939908760879111291 join aggView5147404093602487343 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin854578528329203861;
