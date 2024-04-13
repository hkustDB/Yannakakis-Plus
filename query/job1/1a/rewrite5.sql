create or replace view aggView9069166331081518797 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin688926039713232285 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView9069166331081518797 where mi_idx.movie_id=aggView9069166331081518797.v15;
create or replace view aggView5154727696383342910 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4898368534054824108 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5154727696383342910 where mc.company_type_id=aggView5154727696383342910.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4900419281520845540 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2152300837090740992 as select v15, v28, v29 from aggJoin688926039713232285 join aggView4900419281520845540 using(v3);
create or replace view aggView3440121250221321437 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2152300837090740992 group by v15,v28,v29;
create or replace view aggJoin40682820103290062 as select v9, v28, v29 from aggJoin4898368534054824108 join aggView3440121250221321437 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin40682820103290062;
