create or replace view aggView1747538543395757123 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4527062256001797327 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1747538543395757123 where mi_idx.info_type_id=aggView1747538543395757123.v3;
create or replace view aggView7780422402115697750 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1574403230488778950 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7780422402115697750 where mc.company_type_id=aggView7780422402115697750.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView769811420144705376 as select v15 from aggJoin4527062256001797327 group by v15;
create or replace view aggJoin6416089388339866742 as select v15, v9 from aggJoin1574403230488778950 join aggView769811420144705376 using(v15);
create or replace view aggView2361389565727014540 as select v15, MIN(v9) as v27 from aggJoin6416089388339866742 group by v15;
create or replace view aggJoin982551400471706591 as select title as v16, production_year as v19, v27 from title as t, aggView2361389565727014540 where t.id=aggView2361389565727014540.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin982551400471706591;
