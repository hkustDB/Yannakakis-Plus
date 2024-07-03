create or replace view aggView741272990927417470 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8581106679695115034 as select movie_id as v15 from movie_info_idx as mi_idx, aggView741272990927417470 where mi_idx.info_type_id=aggView741272990927417470.v3;
create or replace view aggView2292808811130796154 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4878771215738148295 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2292808811130796154 where mc.company_type_id=aggView2292808811130796154.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2167328815432963997 as select v15 from aggJoin8581106679695115034 group by v15;
create or replace view aggJoin4430525305795457963 as select v15, v9 from aggJoin4878771215738148295 join aggView2167328815432963997 using(v15);
create or replace view aggView8594918025802422876 as select v15, MIN(v9) as v27 from aggJoin4430525305795457963 group by v15;
create or replace view aggJoin5008083514365967837 as select title as v16, production_year as v19, v27 from title as t, aggView8594918025802422876 where t.id=aggView8594918025802422876.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5008083514365967837;
