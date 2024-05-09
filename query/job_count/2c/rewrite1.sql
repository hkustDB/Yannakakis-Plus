create or replace view aggView5601066215770068358 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1224854732674226346 as select movie_id as v12 from movie_keyword as mk, aggView5601066215770068358 where mk.keyword_id=aggView5601066215770068358.v18;
create or replace view aggView7689273749839672705 as select v12, COUNT(*) as annot from aggJoin1224854732674226346 group by v12;
create or replace view aggJoin7562062367936281428 as select id as v12, annot from title as t, aggView7689273749839672705 where t.id=aggView7689273749839672705.v12;
create or replace view aggView2797916591665685840 as select v12, SUM(annot) as annot from aggJoin7562062367936281428 group by v12;
create or replace view aggJoin6023657093869939289 as select company_id as v1, annot from movie_companies as mc, aggView2797916591665685840 where mc.movie_id=aggView2797916591665685840.v12;
create or replace view aggView7514431690219863396 as select v1, SUM(annot) as annot from aggJoin6023657093869939289 group by v1;
create or replace view aggJoin991187784437158156 as select country_code as v3, annot from company_name as cn, aggView7514431690219863396 where cn.id=aggView7514431690219863396.v1 and country_code= '[sm]';
select SUM(annot) as v31 from aggJoin991187784437158156;
