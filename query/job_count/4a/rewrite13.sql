create or replace view aggView8567083100215033650 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3963902928559867423 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8567083100215033650 where mi_idx.info_type_id=aggView8567083100215033650.v1 and info>'5.0';
create or replace view aggView2751840029825715969 as select v14, COUNT(*) as annot from aggJoin3963902928559867423 group by v14;
create or replace view aggJoin1215377442815800410 as select id as v14, production_year as v18, annot from title as t, aggView2751840029825715969 where t.id=aggView2751840029825715969.v14 and production_year>2005;
create or replace view aggView1274428895333362724 as select v14, SUM(annot) as annot from aggJoin1215377442815800410 group by v14;
create or replace view aggJoin1985100961777833944 as select keyword_id as v3, annot from movie_keyword as mk, aggView1274428895333362724 where mk.movie_id=aggView1274428895333362724.v14;
create or replace view aggView2584226635883775810 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5342296529398141740 as select annot from aggJoin1985100961777833944 join aggView2584226635883775810 using(v3);
select SUM(annot) as v26 from aggJoin5342296529398141740;
