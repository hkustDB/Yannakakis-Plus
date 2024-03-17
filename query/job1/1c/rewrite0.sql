create or replace view aggView7560564853605046537 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8455560526702099200 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7560564853605046537 where mc.company_type_id=aggView7560564853605046537.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5985168305635505929 as select v15, MIN(v9) as v27 from aggJoin8455560526702099200 group by v15;
create or replace view aggJoin3762156647946002880 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView5985168305635505929 where t.id=aggView5985168305635505929.v15 and production_year>2010;
create or replace view aggView1365673813087438164 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3762156647946002880 group by v15;
create or replace view aggJoin2680825779205857107 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView1365673813087438164 where mi_idx.movie_id=aggView1365673813087438164.v15;
create or replace view aggView6378508612743595303 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2680825779205857107 group by v3;
create or replace view aggJoin7439000494199533065 as select v27, v28, v29 from info_type as it, aggView6378508612743595303 where it.id=aggView6378508612743595303.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7439000494199533065;
