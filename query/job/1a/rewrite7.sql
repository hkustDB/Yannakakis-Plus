create or replace view aggView6675919086740985371 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2733463863535011917 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6675919086740985371 where mi_idx.info_type_id=aggView6675919086740985371.v3;
create or replace view aggView8132088295845141317 as select v15 from aggJoin2733463863535011917 group by v15;
create or replace view aggJoin436172201241524041 as select id as v15, title as v16, production_year as v19 from title as t, aggView8132088295845141317 where t.id=aggView8132088295845141317.v15;
create or replace view aggView6551765474877949847 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin327380296662895430 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6551765474877949847 where mc.company_type_id=aggView6551765474877949847.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView7335633725979823646 as select v15, MIN(v9) as v27 from aggJoin327380296662895430 group by v15;
create or replace view aggJoin9140450703498611355 as select v16, v19, v27 from aggJoin436172201241524041 join aggView7335633725979823646 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin9140450703498611355;
