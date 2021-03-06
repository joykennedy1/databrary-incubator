-- converted
select 
  'cp /nyu/store/' || substr(cast(sha1 as varchar(80)), 3, 2) || '/' || right(cast(sha1 as varchar(80)), -4) 
  || ' /nyu/stage/ebergelson/' || volume || '/' || container || '/' || name 
from slot_asset sa 
  inner join asset a on sa.asset = a.id 
where container = <SLOT ID>;

-- original
select 
  'cp /nyu/store/' || substr(cast(oa.sha1 as varchar(80)), 3, 2) || '/' || right(cast(oa.sha1 as varchar(80)), -4) 
  || ' /nyu/stage/ebergelson/' || a.volume || '/' || sa.container || '/' || oa.name 
from slot_asset sa 
  inner join asset a on sa.asset = a.id  
  inner join transcode t on t.asset = a.id
  inner join asset oa on t.orig = oa.id
where sa.container = <SLOT ID>;


-- copy into shell script
-- add mkdir at top of script
-- add set -x to echo command, as they take time to run
-- bash scriptname.sh  - can take up to ten minutes to complete, watch top

-- run the converted copy before the original copy, so that the converted "wins" in any conflict

-- generate manifest of copied files by using same query with only target ouptut (or ls -1 in the output dir)
