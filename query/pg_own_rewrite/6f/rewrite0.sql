create or replace view aggView5917588543447558814 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6024059425092586098 as select movie_id as v23, v35 from movie_keyword as mk, aggView5917588543447558814 where mk.keyword_id=aggView5917588543447558814.v8;
create or replace view aggView1066894617753655561 as select v23, MIN(v35) as v35 from aggJoin6024059425092586098 group by v23,v35;
create or replace view aggJoin861076923620500775 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView1066894617753655561 where t.id=aggView1066894617753655561.v23 and production_year>2000;
create or replace view aggView1429965836966552508 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin861076923620500775 group by v23,v35;
create or replace view aggJoin3871114051600317294 as select person_id as v14, v35, v37 from cast_info as ci, aggView1429965836966552508 where ci.movie_id=aggView1429965836966552508.v23;
create or replace view aggView8559673102101066314 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3871114051600317294 group by v14,v37,v35;
create or replace view aggJoin3352745949206974190 as select name as v15, v35, v37 from name as n, aggView8559673102101066314 where n.id=aggView8559673102101066314.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3352745949206974190;
