create or replace view aggView8288317846185234613 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5856463316552145664 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8288317846185234613 where mc.company_type_id=aggView8288317846185234613.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView354077619465606222 as select v15, MIN(v9) as v27 from aggJoin5856463316552145664 group by v15;
create or replace view aggJoin3283506055051721810 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView354077619465606222 where t.id=aggView354077619465606222.v15 and production_year>2000;
create or replace view aggView1147693577882350950 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3283506055051721810 group by v15,v27;
create or replace view aggJoin1598454169844449482 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView1147693577882350950 where mi_idx.movie_id=aggView1147693577882350950.v15;
create or replace view aggView2238008597052661191 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7096390992228563548 as select v27, v28, v29 from aggJoin1598454169844449482 join aggView2238008597052661191 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7096390992228563548;
